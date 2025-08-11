# PRIME API Reference

## Overview

The PRIME API provides programmatic access to all trading functionality, strategy management, and performance monitoring capabilities.

## Installation

```bash
pip install prime-trading
```

Or from source:
```bash
git clone https://github.com/your-org/prime.git
cd prime
pip install -e .
```

## Authentication

```python
from prime import PrimeClient

# Initialize with API credentials
client = PrimeClient(
    api_key='your_api_key',
    secret_key='your_secret_key',
    base_url='https://api.prime-trading.ai'  # or 'paper' for testing
)
```

## Core Classes

### PrimeTrader

Main trading orchestrator that manages strategies, positions, and risk.

```python
from prime import PrimeTrader

trader = PrimeTrader(
    mode='paper',  # 'paper' or 'live'
    config_file='config.json'  # optional
)
```

#### Methods

**`start()`**
Starts the automated trading system.
```python
trader.start()
```

**`stop()`**
Stops all trading activity gracefully.
```python
trader.stop()
```

**`get_status()`**
Returns current system status.
```python
status = trader.get_status()
# Returns: {'running': True, 'strategies': 42, 'positions': 15, ...}
```

### Strategy

Base class for all trading strategies.

```python
from prime.strategies import Strategy

class MyStrategy(Strategy):
    def __init__(self, params=None):
        super().__init__(params)
        self.name = "My Custom Strategy"
    
    def generate_signals(self, data):
        # Implementation
        return signals
```

#### Methods

**`generate_signals(data)`**
Generate trading signals from market data.
- **Parameters**: 
  - `data` (DataFrame): Market data with OHLCV
- **Returns**: List[Signal]

**`backtest(start_date, end_date)`**
Run backtest for the strategy.
```python
results = strategy.backtest('2024-01-01', '2024-12-31')
```

### Signal

Trading signal representation.

```python
from prime.models import Signal

signal = Signal(
    symbol='AAPL',
    action='BUY',  # 'BUY', 'SELL', 'HOLD'
    confidence=0.85,  # 0.0 to 1.0
    strategy='momentum',
    timestamp=datetime.now()
)
```

#### Attributes
- `symbol` (str): Trading symbol
- `action` (str): BUY, SELL, or HOLD
- `confidence` (float): Confidence score 0-1
- `strategy` (str): Source strategy name
- `timestamp` (datetime): Signal generation time
- `metadata` (dict): Additional information

### Portfolio

Portfolio management and risk control.

```python
from prime import Portfolio

portfolio = Portfolio(
    initial_capital=100000,
    max_positions=20,
    risk_per_trade=0.02
)
```

#### Methods

**`get_positions()`**
Get all current positions.
```python
positions = portfolio.get_positions()
# Returns: List[Position]
```

**`get_value()`**
Get total portfolio value.
```python
value = portfolio.get_value()
# Returns: float
```

**`get_metrics()`**
Get performance metrics.
```python
metrics = portfolio.get_metrics()
# Returns: {'sharpe': 1.8, 'returns': 24.3, ...}
```

## Trading Operations

### Placing Orders

```python
# Market order
order = trader.place_order(
    symbol='AAPL',
    quantity=100,
    side='buy',
    order_type='market'
)

# Limit order
order = trader.place_order(
    symbol='AAPL',
    quantity=100,
    side='buy',
    order_type='limit',
    limit_price=150.00
)

# Stop loss order
order = trader.place_order(
    symbol='AAPL',
    quantity=100,
    side='sell',
    order_type='stop',
    stop_price=145.00
)
```

### Order Management

```python
# Get all orders
orders = trader.get_orders(status='open')

# Cancel order
trader.cancel_order(order_id='123456')

# Modify order
trader.modify_order(
    order_id='123456',
    quantity=150,
    limit_price=151.00
)
```

### Position Management

```python
# Get position
position = trader.get_position('AAPL')

# Close position
trader.close_position('AAPL')

# Close all positions
trader.close_all_positions()

# Set stop loss
trader.set_stop_loss('AAPL', stop_price=145.00)

# Set take profit
trader.set_take_profit('AAPL', target_price=160.00)
```

## Strategy Management

### Loading Strategies

```python
# Load built-in strategy
trader.load_strategy('momentum')

# Load custom strategy
from my_strategies import CustomStrategy
trader.load_strategy(CustomStrategy())

# Load multiple strategies
trader.load_strategies(['momentum', 'mean_reversion', 'pairs'])
```

### Configuring Strategies

```python
# Configure individual strategy
trader.configure_strategy('momentum', {
    'lookback_period': 20,
    'entry_threshold': 2.0,
    'stop_loss': 0.02
})

# Set strategy weights
trader.set_strategy_weights({
    'momentum': 0.4,
    'mean_reversion': 0.3,
    'pairs': 0.3
})

# Enable/disable strategies
trader.enable_strategy('momentum')
trader.disable_strategy('pairs')
```

### Strategy Performance

```python
# Get strategy performance
perf = trader.get_strategy_performance('momentum')
# Returns: {'sharpe': 1.9, 'returns': 26.7, 'trades': 145, ...}

# Compare strategies
comparison = trader.compare_strategies()
# Returns DataFrame with all strategy metrics
```

## Data Operations

### Market Data

```python
# Get real-time quote
quote = trader.get_quote('AAPL')

# Get historical data
data = trader.get_historical_data(
    symbol='AAPL',
    start='2024-01-01',
    end='2024-12-31',
    timeframe='1d'
)

# Stream real-time data
def on_quote(quote):
    print(f"{quote.symbol}: ${quote.price}")

trader.stream_quotes(['AAPL', 'GOOGL'], callback=on_quote)
```

### Technical Indicators

```python
from prime.indicators import Indicators

ind = Indicators(data)

# Simple indicators
sma = ind.sma(period=20)
ema = ind.ema(period=12)
rsi = ind.rsi(period=14)
macd = ind.macd(fast=12, slow=26, signal=9)

# Complex indicators
bollinger = ind.bollinger_bands(period=20, std=2)
ichimoku = ind.ichimoku()
fibonacci = ind.fibonacci_retracements()
```

## Risk Management

### Risk Configuration

```python
# Set global risk parameters
trader.set_risk_parameters({
    'max_portfolio_risk': 0.10,  # 10% maximum
    'max_position_size': 0.05,   # 5% per position
    'max_correlation': 0.7,       # Maximum correlation
    'max_leverage': 1.0           # No leverage
})

# Set stop loss for all positions
trader.set_global_stop_loss(percent=0.02)

# Set daily loss limit
trader.set_daily_loss_limit(percent=0.05)
```

### Risk Monitoring

```python
# Get current risk metrics
risk = trader.get_risk_metrics()
# Returns: {'var_95': 5000, 'portfolio_beta': 0.8, ...}

# Check risk violations
violations = trader.check_risk_violations()
# Returns: List of any risk limit breaches

# Get exposure by sector
exposure = trader.get_sector_exposure()
```

## Backtesting

### Running Backtests

```python
from prime import Backtest

# Simple backtest
backtest = Backtest(
    strategy='momentum',
    start_date='2023-01-01',
    end_date='2023-12-31',
    initial_capital=100000
)

results = backtest.run()
```

### Backtest Configuration

```python
# Advanced backtest
backtest = Backtest(
    strategies=['momentum', 'mean_reversion'],
    start_date='2020-01-01',
    end_date='2023-12-31',
    initial_capital=100000,
    commission=0.001,  # 0.1%
    slippage=0.001,    # 0.1%
    data_frequency='1m'  # 1-minute bars
)

# Run with walk-forward analysis
results = backtest.run_walk_forward(
    window_size=252,  # 1 year
    step_size=21      # 1 month
)
```

### Analyzing Results

```python
# Get metrics
print(f"Sharpe Ratio: {results.sharpe_ratio}")
print(f"Total Return: {results.total_return}%")
print(f"Max Drawdown: {results.max_drawdown}%")

# Plot results
results.plot_equity_curve()
results.plot_drawdown()
results.plot_returns_distribution()

# Export results
results.to_csv('backtest_results.csv')
results.to_json('backtest_results.json')
```

## Performance Monitoring

### Real-time Metrics

```python
# Get current performance
metrics = trader.get_performance_metrics()

# Subscribe to performance updates
def on_performance_update(metrics):
    print(f"Current Sharpe: {metrics['sharpe']}")
    print(f"Today's P&L: ${metrics['daily_pnl']}")

trader.subscribe_performance(callback=on_performance_update)
```

### Historical Analysis

```python
# Get trade history
trades = trader.get_trade_history(days=30)

# Analyze performance by strategy
strategy_perf = trader.analyze_strategy_performance()

# Get monthly returns
monthly = trader.get_monthly_returns()

# Calculate rolling metrics
rolling_sharpe = trader.get_rolling_sharpe(window=30)
```

## WebSocket Streams

### Real-time Data Streams

```python
from prime import WebSocketClient

ws = WebSocketClient()

# Subscribe to trades
@ws.on('trade')
def on_trade(trade):
    print(f"Trade: {trade.symbol} @ ${trade.price}")

# Subscribe to quotes
@ws.on('quote')
def on_quote(quote):
    print(f"Quote: {quote.bid} / {quote.ask}")

# Subscribe to signals
@ws.on('signal')
def on_signal(signal):
    print(f"Signal: {signal.action} {signal.symbol}")

ws.connect()
ws.subscribe(['AAPL', 'GOOGL'])
```

## Error Handling

### Exception Types

```python
from prime.exceptions import (
    InsufficientFundsError,
    PositionNotFoundError,
    StrategyError,
    DataError,
    RiskLimitError
)

try:
    trader.place_order('AAPL', 1000, 'buy')
except InsufficientFundsError as e:
    print(f"Not enough funds: {e}")
except RiskLimitError as e:
    print(f"Risk limit exceeded: {e}")
```

### Error Recovery

```python
# Set error handlers
trader.on_error = lambda e: print(f"Error: {e}")
trader.on_disconnect = lambda: trader.reconnect()

# Automatic retry configuration
trader.configure_retry(
    max_attempts=3,
    delay=5,  # seconds
    backoff=2  # exponential backoff multiplier
)
```

## Utilities

### Data Validation

```python
from prime.utils import validate_data

# Validate market data
is_valid = validate_data(df)

# Clean data
from prime.utils import clean_data
cleaned_df = clean_data(df, fill_method='forward')
```

### Performance Metrics

```python
from prime.metrics import calculate_sharpe, calculate_drawdown

sharpe = calculate_sharpe(returns, risk_free_rate=0.02)
max_dd = calculate_drawdown(equity_curve)
```

## Rate Limits

API rate limits:
- **Market Data**: 200 requests/minute
- **Trading**: 100 orders/minute
- **Account**: 10 requests/minute

```python
# Check rate limit status
limits = client.get_rate_limits()
print(f"Remaining: {limits.remaining}")
print(f"Reset at: {limits.reset_time}")
```

## Webhooks

Configure webhooks for events:

```python
# Register webhook
trader.register_webhook(
    url='https://your-server.com/webhook',
    events=['trade', 'signal', 'error'],
    secret='your_webhook_secret'
)
```

## Examples

### Complete Trading Bot

```python
from prime import PrimeTrader
import time

# Initialize
trader = PrimeTrader(mode='paper')

# Configure
trader.configure({
    'risk_level': 'moderate',
    'strategies': ['momentum', 'mean_reversion'],
    'max_positions': 10
})

# Set risk limits
trader.set_risk_parameters({
    'max_position_size': 0.05,
    'daily_loss_limit': 0.02
})

# Start trading
trader.start()

# Monitor
while True:
    metrics = trader.get_performance_metrics()
    print(f"P&L: ${metrics['total_pnl']}")
    print(f"Positions: {metrics['position_count']}")
    time.sleep(60)
```

### Custom Strategy Implementation

```python
from prime.strategies import Strategy
from prime.indicators import Indicators

class MyMomentumStrategy(Strategy):
    def __init__(self):
        super().__init__()
        self.name = "Custom Momentum"
        
    def generate_signals(self, data):
        signals = []
        ind = Indicators(data)
        
        rsi = ind.rsi(14)
        macd = ind.macd()
        
        if rsi[-1] > 70 and macd['macd'][-1] > macd['signal'][-1]:
            signals.append(self.create_signal(
                symbol=data.symbol,
                action='BUY',
                confidence=0.8
            ))
            
        return signals

# Use the strategy
trader = PrimeTrader()
trader.load_strategy(MyMomentumStrategy())
trader.start()
```

## Support

- **Documentation**: https://docs.prime-trading.ai
- **GitHub**: https://github.com/your-org/prime
- **Email**: api@prime-trading.ai
- **Discord**: https://discord.gg/prime

---

*API Version: 2.0.0 | Last Updated: August 2025*
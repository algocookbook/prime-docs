# Getting Started with PRIME

## Quick Start Guide

Welcome to PRIME! This guide will help you get up and running in minutes.

## Prerequisites

### System Requirements
- **OS**: Linux, macOS, or Windows (WSL2)
- **Python**: 3.9 or higher
- **RAM**: Minimum 8GB (16GB recommended)
- **Storage**: 50GB free space
- **Internet**: Stable connection for market data

### Required API Keys
You'll need at least one data provider:
- **Alpaca** (recommended) - [Get free API key](https://alpaca.markets)
- **Yahoo Finance** - No API key needed
- **Polygon** - [Get API key](https://polygon.io)

## Installation

### 1. Clone the Repository
```bash
git clone https://github.com/your-org/prime.git
cd prime
```

### 2. Set Up Python Environment
```bash
# Create virtual environment
python3 -m venv venv

# Activate it
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 3. Configure API Keys
Create a `.env` file in the project root:
```bash
# Alpaca Keys (Paper Trading)
ALPACA_API_KEY=your_api_key_here
ALPACA_SECRET_KEY=your_secret_key_here
ALPACA_BASE_URL=https://paper-api.alpaca.markets

# Optional: Other providers
POLYGON_API_KEY=your_polygon_key
```

### 4. Initialize PRIME
```bash
# Run initial setup
python3 setup.py

# This will:
# - Verify API connections
# - Download initial market data
# - Create necessary directories
# - Set up the database
```

## Your First Trade

### Paper Trading (Recommended to Start)
```python
from prime import PrimeTrader

# Initialize with paper trading
trader = PrimeTrader(mode='paper')

# Use conservative settings initially
trader.configure({
    'risk_level': 'conservative',
    'max_position_size': 0.02,  # 2% per position
    'strategies': ['momentum', 'mean_reversion']
})

# Start automated trading
trader.start()

# Monitor in real-time
trader.show_dashboard()  # Opens web dashboard at localhost:8000
```

### Manual Signal Generation
```python
# Get trading signals without executing
signals = trader.get_signals('AAPL')

for signal in signals:
    print(f"Signal: {signal.action} {signal.symbol}")
    print(f"Confidence: {signal.confidence}%")
    print(f"Strategy: {signal.strategy}")
```

## Configuration Examples

### Conservative Configuration
```json
{
  "mode": "paper",
  "risk_management": {
    "max_position_size": 0.02,
    "max_portfolio_risk": 0.05,
    "stop_loss": 0.01,
    "take_profit": 0.02
  },
  "strategies": {
    "momentum": {"enabled": true, "weight": 0.5},
    "mean_reversion": {"enabled": true, "weight": 0.5}
  }
}
```

### Moderate Configuration
```json
{
  "mode": "paper",
  "risk_management": {
    "max_position_size": 0.05,
    "max_portfolio_risk": 0.10,
    "stop_loss": 0.02,
    "take_profit": 0.04
  },
  "strategies": {
    "momentum": {"enabled": true, "weight": 0.3},
    "mean_reversion": {"enabled": true, "weight": 0.3},
    "pairs_trading": {"enabled": true, "weight": 0.2},
    "ml_ensemble": {"enabled": true, "weight": 0.2}
  }
}
```

### Aggressive Configuration
```json
{
  "mode": "paper",
  "risk_management": {
    "max_position_size": 0.10,
    "max_portfolio_risk": 0.20,
    "stop_loss": 0.03,
    "take_profit": 0.06
  },
  "strategies": {
    "momentum": {"enabled": true, "weight": 0.25},
    "mean_reversion": {"enabled": true, "weight": 0.25},
    "pairs_trading": {"enabled": true, "weight": 0.25},
    "ml_ensemble": {"enabled": true, "weight": 0.25}
  }
}
```

## Monitoring Your Performance

### Web Dashboard
```bash
# Start the dashboard
python3 prime_dashboard.py

# Access at http://localhost:8000
```

### Command Line
```bash
# Check current positions
python3 prime.py status

# View recent trades
python3 prime.py trades --last 10

# Get performance metrics
python3 prime.py performance
```

### Python API
```python
# Get current performance
metrics = trader.get_metrics()
print(f"Total Return: {metrics['total_return']}%")
print(f"Sharpe Ratio: {metrics['sharpe_ratio']}")
print(f"Win Rate: {metrics['win_rate']}%")
print(f"Current Drawdown: {metrics['drawdown']}%")

# Get position details
positions = trader.get_positions()
for pos in positions:
    print(f"{pos.symbol}: {pos.quantity} @ ${pos.avg_price}")
```

## Common Commands

### Strategy Management
```bash
# List available strategies
python3 prime.py strategies list

# Enable/disable strategies
python3 prime.py strategies enable momentum
python3 prime.py strategies disable pairs_trading

# Backtest a strategy
python3 prime.py backtest --strategy momentum --days 30
```

### Risk Management
```bash
# Set position limits
python3 prime.py risk set-limit --max-position 0.05

# Set stop loss
python3 prime.py risk set-stops --stop-loss 0.02

# View current risk exposure
python3 prime.py risk status
```

### Data Management
```bash
# Update market data
python3 prime.py data update

# Download historical data
python3 prime.py data download --symbol AAPL --period 1y

# Clean old data
python3 prime.py data clean --older-than 90d
```

## Troubleshooting

### Connection Issues
```bash
# Test API connections
python3 test_connections.py

# Verify data feed
python3 verify_data.py
```

### Performance Issues
```bash
# Run diagnostics
python3 diagnostics.py

# Check system resources
python3 check_resources.py

# Optimize database
python3 optimize_db.py
```

### Common Errors

**Error: "No API key found"**
- Ensure `.env` file exists with correct keys
- Check environment variables are loaded

**Error: "Insufficient funds"**
- Paper account may need reset
- Check position sizing settings

**Error: "Strategy not found"**
- Run `pip install -r requirements.txt` again
- Verify strategy files are present

## Best Practices

### Start Small
1. Begin with paper trading
2. Use conservative settings
3. Monitor for at least 30 days
4. Gradually increase position sizes

### Risk Management
1. Never risk more than 2% per trade initially
2. Set stop losses on every position
3. Diversify across strategies
4. Monitor correlation between positions

### Performance Tracking
1. Review performance weekly
2. Keep a trading journal
3. Analyze losing trades
4. Adjust parameters based on results

## Next Steps

1. **Read the Full Documentation**: [Complete PRIME Documentation](documentation.md)
2. **Explore Strategies**: [Strategy Catalog](strategies.md)
3. **Learn the API**: [API Reference](api.md)
4. **Join the Community**: [Discord Server](https://discord.gg/prime)

## Getting Help

### Resources
- **Documentation**: [Full Docs](documentation.md)
- **GitHub Issues**: [Report Problems](https://github.com/your-org/prime/issues)
- **Discord**: [Community Support](https://discord.gg/prime)
- **Email**: support@prime-trading.ai

### Quick Help
```bash
# Get help on any command
python3 prime.py --help

# Get strategy-specific help
python3 prime.py strategies momentum --help

# View system status
python3 prime.py doctor
```

---

Welcome to the PRIME community! Start with paper trading, be patient, and always practice proper risk management. Happy trading! 🚀
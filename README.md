### Note: Currently in Development
## Long Short Term Memory (LSTM) :  Verilog Implementation

[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)

<!-- TOC -->

- [Long Short Term Memory (LSTM) :  Verilog Implementation](#Long-Short-Term-Memory-(LSTM)-:-Verilog-Implementation)
  - [Architecture](#architecture)
  - [Code structure](#code-structure)
  - [Acknowledgement](#acknowledgement)

<!-- /TOC -->
Clone this repository:

```bash
git clone https://github.com/ahirsharan/LSTM.git
cd LSTM/
```
## Architecture

### LSTM
![text alt](https://i.ibb.co/vJBtzYB/LSTM.png)


## Code Structure
 
```
.
|
├── lstm_cell.v      # LSTM cell
|
├── sigmoid.v        # Approx Sigmoid Activation         
|
├── tanh.v           # Approx Tanh Activation           
|
├── ConcatMultAdd.v  # Concat and mutiply weights and add bias
|
├── Test.v           # Test Bench for LSTM Cell
|
```

## Acknowledgement
- [LSTM Network](https://colah.github.io/posts/2015-08-Understanding-LSTMs/)

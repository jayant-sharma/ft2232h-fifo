
import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, ReadOnly
from cocotb.result import TestFailure, ReturnValue

@cocotb.coroutine
def reset_fifo(dut):
    """This coroutine performs reset to FIFO"""
    #yield RisingEdge(dut.clK)                  # Synchronise to the read clock
    dut.rsT    = 1
    yield RisingEdge(dut.clK)                  # Wait 1 clock cycle
    dut.rsT    = 0
    
@cocotb.coroutine
def write_fifo(dut, value):
    """This coroutine performs a write of the FIFO"""
    #yield RisingEdge(dut.clK)                  # Synchronise to the read clock
    dut.fifo_IN    = value
    dut.fifo_WR    = 1
    yield RisingEdge(dut.clK)                  # Wait 1 clock cycle
    dut.fifo_WR    = 0                         # Disable write

@cocotb.coroutine
def read_fifo(dut):
    """This coroutine performs a read of the FIFO and returns a value"""
    dut.fifo_RD = 1
    yield RisingEdge(dut.clK)               # Wait for 1 clock cycle
    yield ReadOnly()                        # Wait until all events have executed for this timestep
    raise ReturnValue(int(dut.fifo_OUT.value))  # Read back the value


@cocotb.test()
def test_fifo(dut):
    """Try writing values into the FIFO and reading back"""
    RAM = {}
    
    # Read the parameters back from the DUT to set up our model
    width = dut.DATA.value.integer
    depth = 2**dut.ADDR.value.integer
    dut.log.info("Found %d entry RAM by %d bits wide" % (depth, width))

    # Set up independent read/write clocks
    cocotb.fork(Clock(dut.clK, 3200).start())
    
    dut.log.info("Writing in random values")
    for i in xrange(depth):
        RAM[i] = int(random.getrandbits(width))
        yield write_fifo(dut, RAM[i])

    dut.log.info("Reading back values and checking")
    for i in xrange(depth):
        value = yield read_fifo(dut)
        dut.log.info("%X   %X" % (value, RAM[i]))
        if value != RAM[i]:
            dut.log.error("RAM[%d] expected %d but got %d" % (i, RAM[i], value))
            raise TestFailure("RAM contents incorrect")
    dut.log.info("RAM contents OK")
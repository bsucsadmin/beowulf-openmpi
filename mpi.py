import socket

from mpi4py import MPI

comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()

try:
    import cupy as cp

    local = comm.Split_type(MPI.COMM_TYPE_SHARED).Get_rank()
    dev = local % cp.cuda.runtime.getDeviceCount()
    cp.cuda.Device(dev).use()
    backend = f"cupy (GPU {dev})"
except Exception:
    import numpy as cp

    backend = "numpy (CPU)"

sendbuf = cp.arange(10, dtype="i")
recvbuf = cp.empty_like(sendbuf)

if backend.startswith("cupy"):
    cp.cuda.get_current_stream().synchronize()

comm.Allreduce(sendbuf, recvbuf)

assert cp.allclose(recvbuf, sendbuf * size)
print(f"rank {rank} of {size} on {socket.gethostname()} [{backend}] -> {recvbuf}",
      flush=True)

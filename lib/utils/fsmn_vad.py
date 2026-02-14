import sys
from pathlib import Path
MODEL_PATH = Path("/root/sensevoice-server/models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043")
if str(MODEL_PATH) not in sys.path:
    sys.path.insert(0, str(MODEL_PATH))
from sensevoice_rknn import FSMNVad
__all__ = ['FSMNVad']
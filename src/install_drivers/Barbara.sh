sudo apt install -y pika-amdgpu-core                                                                                                                # Base driver
sudo apt install -y vulkan-amdgpu-pro vulkan-amdgpu-pro:i386                                                                                        # AMD Proprietary Vulkan implementation
sudo apt install -y amf-amdgpu-pro                                                                                                                  # AMD "Advanced Media Framework" can be used for H265/H264 encoding & decoding
sudo apt install -y amdvlk amdvlk:i386                                                                                                              # AMD 1st party Vulkan implementation
sudo apt install -y ocl-icd-libopencl1-amdgpu-pro ocl-icd-libopencl1-amdgpu-pro:i386 opencl-legacy-amdgpu-pro-icd opencl-legacy-amdgpu-pro-icd:i386 # AMD Proprietary OpenCL implementation (For RainbowMiner)
sudo apt install -y pika-rocm-meta                                                                                                                  # Equivalent to Cuda, needed for Blender and such programs

# SuvKernel

Kernel for the Xiaomi **redwood** (POCO X5 Pro 5G / Redmi Note 12 Pro Speed),
for CLO based ROMs. It keeps Qualcomm's WALT scheduler, which the CLO perf
and power HALs expect, and adds KernelSU-Next and SuSFS.

`Linux 5.4.295` · `WALT` · `Neutron Clang 24` · `arm64`

## Build

Extract [Neutron Clang](https://github.com/Neutron-Toolchains/clang-build-catalogue)
to `~/toolchains/neutron-clang` (or point `CLANG` at it), then:

```bash
./build.sh
```

The image lands at `out/arch/arm64/boot/Image`, the device trees at
`out/arch/arm64/boot/dts/vendor/qcom/yupik.dtb` and
`out/arch/arm64/boot/dts/vendor/qcom/redwood-sm7325-overlay.dtbo`.

## Credits

- [AtomX](https://github.com/Atom-X-Devs/android_kernel_xiaomi_sm7325) by
  Atom-X-Devs, the base tree
- [Vajra](https://github.com/genie1997/android_kernel_xiaomi_redwood) by
  genie1997, for the KernelSU-Next and SuSFS integration
- [KernelSU-Next](https://github.com/KernelSU-Next/KernelSU-Next)
- [SuSFS](https://gitlab.com/simonpunk/susfs4ksu) by simonpunk

## License

GPL-2.0. See `COPYING`.

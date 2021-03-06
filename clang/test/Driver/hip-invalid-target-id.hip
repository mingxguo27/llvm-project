// REQUIRES: clang-driver
// REQUIRES: x86-registered-target
// REQUIRES: amdgpu-registered-target

// RUN: %clang -### -target x86_64-linux-gnu \
// RUN:   -x hip --offload-arch=gfx908 \
// RUN:   --offload-arch=gfx908xnack \
// RUN:   --rocm-path=%S/Inputs/rocm \
// RUN:   %s 2>&1 | FileCheck -check-prefix=NOPLUS %s

// NOPLUS: error: Invalid target ID: gfx908xnack

// RUN: %clang -### -target x86_64-linux-gnu \
// RUN:   -x hip --offload-arch=gfx900 \
// RUN:   --offload-arch=gfx908:xnack+:xnack+ \
// RUN:   --rocm-path=%S/Inputs/rocm \
// RUN:   %s 2>&1 | FileCheck -check-prefix=ORDER %s

// ORDER: error: Invalid target ID: gfx908:xnack+:xnack+

// RUN: %clang -### -target x86_64-linux-gnu \
// RUN:   -x hip --offload-arch=gfx908 \
// RUN:   --offload-arch=gfx908:unknown+ \
// RUN:   --offload-arch=gfx908+sram-ecc+unknown \
// RUN:   --offload-arch=gfx900+xnack \
// RUN:   --rocm-path=%S/Inputs/rocm \
// RUN:   %s 2>&1 | FileCheck -check-prefix=UNK %s

// UNK: error: Invalid target ID: gfx908:unknown+

// RUN: %clang -### -target x86_64-linux-gnu \
// RUN:   -x hip --offload-arch=gfx908 \
// RUN:   --offload-arch=gfx908:sram-ecc+:unknown+ \
// RUN:   --offload-arch=gfx900+xnack \
// RUN:   --rocm-path=%S/Inputs/rocm \
// RUN:   %s 2>&1 | FileCheck -check-prefix=MIXED %s

// MIXED: error: Invalid target ID: gfx908:sram-ecc+:unknown+

// RUN: %clang -### -target x86_64-linux-gnu \
// RUN:   -x hip --offload-arch=gfx908 \
// RUN:   --offload-arch=gfx900:sram-ecc+ \
// RUN:   --rocm-path=%S/Inputs/rocm \
// RUN:   %s 2>&1 | FileCheck -check-prefix=UNSUP %s

// UNSUP: error: Invalid target ID: gfx900:sram-ecc+

/ RUN: %clang -### -target x86_64-linux-gnu \
// RUN:   -x hip --offload-arch=gfx908 \
// RUN:   --offload-arch=gfx900:xnack \
// RUN:   --rocm-path=%S/Inputs/rocm \
// RUN:   %s 2>&1 | FileCheck -check-prefix=NOSIGN %s

// NOSIGN: error: Invalid target ID: gfx900:xnack

// RUN: %clang -### -target x86_64-linux-gnu \
// RUN:   -x hip --offload-arch=gfx908 \
// RUN:   --offload-arch=gfx900+xnack \
// RUN:   --rocm-path=%S/Inputs/rocm \
// RUN:   %s 2>&1 | FileCheck -check-prefix=NOCOLON %s

// NOCOLON: error: Invalid target ID: gfx900+xnack

// RUN: not %clang -### -target x86_64-linux-gnu \
// RUN:   -x hip --offload-arch=gfx908 \
// RUN:   --offload-arch=gfx908:xnack+ \
// RUN:   --rocm-path=%S/Inputs/rocm \
// RUN:   %s 2>&1 | FileCheck -check-prefix=COMBO %s

// COMBO: error: Invalid offload arch combinations: gfx908 and gfx908:xnack+

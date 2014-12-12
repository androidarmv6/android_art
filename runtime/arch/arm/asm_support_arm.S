/*
 * Copyright (C) 2013 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef ART_RUNTIME_ARCH_ARM_ASM_SUPPORT_ARM_S_
#define ART_RUNTIME_ARCH_ARM_ASM_SUPPORT_ARM_S_

#include "asm_support_arm.h"

// Define special registers.

// Register holding suspend check count down.
#define rSUSPEND r4
// Register holding Thread::Current().
#define rSELF r9

.syntax unified
#if __ARM_ARCH >= 7
.arch armv7-a
#else
.arch armv6k
#endif
.thumb

.macro ENTRY name
    .arm
    .type \name, #function
    .hidden \name  // Hide this as a global symbol, so we do not incur plt calls.
    .global \name
    /* Cache alignment for function entry */
    .balign 16
\name:
    .cfi_startproc
     /* Ensure we get a sane starting CFA. */
     .cfi_def_cfa sp,0
    .fnstart
.endm

.macro ENTRY_NO_HIDE name
    .arm
    .type \name, #function
    .global \name
    /* Cache alignment for function entry */
    .balign 16
\name:
    .cfi_startproc
     /* Ensure we get a sane starting CFA. */
     .cfi_def_cfa sp,0
    .fnstart
.endm

.macro ARM_ENTRY name
    .arm
    .type \name, #function
    .hidden \name  // Hide this as a global symbol, so we do not incur plt calls.
    .global \name
    /* Cache alignment for function entry */
    .balign 16
\name:
    .cfi_startproc
     /* Ensure we get a sane starting CFA. */
    .cfi_def_cfa sp,0
    .fnstart
.endm

.macro ARM_ENTRY_NO_HIDE name
    .arm
    .type \name, #function
    .global \name
    /* Cache alignment for function entry */
    .balign 16
\name:
    .cfi_startproc
     /* Ensure we get a sane starting CFA. */
    .cfi_def_cfa sp,0
    .fnstart
.endm

.macro END name
    .fnend
    .cfi_endproc
    .size \name, .-\name
.endm

.macro UNIMPLEMENTED name
    ENTRY \name
    bkpt
    bkpt
    END \name
.endm

#endif  // ART_RUNTIME_ARCH_X86_ASM_SUPPORT_X86_S_

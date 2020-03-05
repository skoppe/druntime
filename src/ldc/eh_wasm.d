/**
 * This module implements the runtime-part of LDC exceptions
 * on Windows, based on the MSVC++ runtime.
 */
module ldc.eh_wasm;

version (WebAssembly):

import rt.unwind;
extern (C) void _d_throw_exception(Throwable t) {
  import core.stdc.stdio;
  import core.internal.abort : abort;
  auto msg = t.toString();
  printf("Throw Exception: %.*s @ %.*s:%d\n", cast(uint)msg.length, msg.ptr, cast(uint)t.file.length, t.file.ptr, t.line);
  assert(0, "cannot throw, aborting"); // assert 0 gets translated to an unreachable. That gives us a stack trace in many WASM engines. An abort will do the same but without a stack trace.
}

extern (C) void _Unwind_Resume(void*) {
  assert(0, "No unwind support");
}

extern(C) Throwable _d_eh_enter_catch(_Unwind_Exception* exceptionObject) {
  assert(0, "No catch support");
}

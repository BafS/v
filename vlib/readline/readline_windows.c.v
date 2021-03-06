// Copyright (c) 2019-2020 Alexander Medvednikov. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.

// Windows version
// Need to be implemented
// Will serve as more advanced input method
// Based on the work of https://github.com/AmokHuginnsson/replxx

module readline

import os

// Only use standard os.get_line
// Need implementation for readline capabilities
pub fn (r mut Readline) read_line_utf8(prompt string) ?ustring {
  r.current = ''.ustring()
  r.cursor = 0
  r.prompt = prompt
  r.search_index = 0
  if r.previous_lines.len <= 1 {
    r.previous_lines << ''.ustring()
    r.previous_lines << ''.ustring()
  }
  else {
    r.previous_lines[0] = ''.ustring()
  }

  print(r.prompt)
  r.current = os.get_raw_line().ustring()

  r.previous_lines[0] = ''.ustring()
  r.search_index = 0
  if r.current.s == '' {
    return error('empty line')
  }
  return r.current
}

// Returns the string from the utf8 ustring
pub fn (r mut Readline) read_line(prompt string) ?string {
  s := r.read_line_utf8(prompt) or {
    return error(err)
  }
  return s.s
}

// Standalone function without persistent functionnalities (eg: history)
// Returns utf8 based ustring
pub fn read_line_utf8(prompt string) ?ustring {
  mut r := Readline{}
  s := r.read_line_utf8(prompt) or {
    return error(err)
  }
  return s
}

// Standalone function without persistent functionnalities (eg: history)
// Return string from utf8 ustring
pub fn read_line(prompt string) ?string {
  mut r := Readline{}
  s := r.read_line(prompt) or {
    return error(err)
  }
  return s
}

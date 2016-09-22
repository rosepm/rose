Rose adheres to the following coding style:

* Lines should wrap at column 80. Exceptions can be made, but only if there's
  really no other clean way to do it.
* Indentation is 2-space.
* Functions should be of the form:

```bash
    function() {
       ...
    }
```

* Exceptions to that form include various usage and similar output functions.
* Top of each file should have one line comment description followed by
  copyright notice.
* For the most part, you should use the various output classes to print things
  on screen.
* Functions starting with an underscore are considered local to the module
  they are found in and should not be used outside.
* Variables that are ALL_CAPS are considered global (even though it's all
  global, yo.)
* Transitory and temporary variables used in functions should be set local.
  Exceptions include iterators and other simple things where declaring them
  local beforehand results in uglier code.

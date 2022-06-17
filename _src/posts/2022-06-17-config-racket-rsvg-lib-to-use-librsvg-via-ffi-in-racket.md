    Title: config racket/rsvg lib to use librsvg via FFI in Racket
    Date: 2022-06-17T14:31:39
    Tags: racket,ffi


I have a little Racket program that dependences `racket/rsvg`, so I install the `racket/rsvg` lib on my macOS using under command

```bash
raco pkg install -u rsvg
```

but when I then run the program, it produces some error messages

> ffi-lib: couldn't open "librsvg-2.2.dylib" (dlopen(librsvg-2.2.dylib, 6): image not found)

after check the racket's `ffi-lib` doc, I fixed it, the follow is How I fix the problem. originally posted on [github](https://github.com/takikawa/racket-rsvg/issues/7#issuecomment-729429563)

I have the same problem, and when I checked the method `ffi-lib` [doc](https://docs.racket-lang.org/foreign/Loading_Foreign_Libraries.html#%28def._%28%28lib._ffi%2Funsafe..rkt%29._ffi-lib%29%29), it explains how racket finds ffi lib path

> If *path* is not an absolute path, look in each directory reported by `get-lib-dirs`; the default list is the result of `(get-lib-search-dirs)`.

as the racket document describes, we can use the code under here to get the current lib search dirs

```racket
(require setup/dirs)
(get-lib-search-dirs)
```

on my computer the result is `'(#<path:/Users/mywo/Library/Racket/7.9/lib> #<path:/usr/local/opt/Racket/lib>)`. and my librsvg lib path is `/usr/local/Cellar/librsvg/2.48.8/lib/librsvg-2.2.dylib`, which can find with `homebrew`

```bash
brew list librsvg
```

if you don't have librsvg in you system, you can install it using Homebrew

```bash
brew install librsvg
```

the racket document shows we can config lib search dirs, follow the [Installation Configuration and Search Paths](https://docs.racket-lang.org/raco/config-file.html) I changed my racket config file `/Applications/Racket v7.9/etc/config.rktd`, add the `'lib-search-dirs'` setting to it, and my program running correctly.

here is my `config.rktd` content

```racket
#hash((build-stamp . "")
      (catalogs . ("https://download.racket-lang.org/releases/7.9/catalog/" #f))
      (doc-search-url . "https://download.racket-lang.org/releases/7.9/doc/local-redirect/index.html")
      (lib-search-dirs . ("/usr/local/opt/librsvg/lib/" #f)))
```

#### racket ffi 使用相关说明

- http://prl.ccs.neu.edu/blog/2016/06/27/tutorial-using-racket-s-ffi/
- http://prl.ccs.neu.edu/blog/2016/06/29/tutorial-racket-ffi-part-2/
- http://prl.ccs.neu.edu/blog/2016/07/11/tutorial-racket-ffi-part-3/

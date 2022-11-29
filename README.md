# r-vegetation

## Installing blogdown

To build this page and serve in your local machine, you need to install
`blogdown` in **R**.

```r
install.packages("blogdown")
```

Additionally you may need to install Hugo:

```r
library(blogdown)
install_hugo()
```

## Build and serve the site

Once you have edited the content or just need to have a preview of the version
in your branch, you can locally build and serve the site.

```r
build_site(build_rmd = TRUE)
serve_site()
```

Note that while you are serving the site, you can see changes while you edit
the rmarkdown sources in your session.
Once you are done, you can stop the server.

```r
stop_server()
```

Enjoy!





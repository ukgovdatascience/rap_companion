# Producing the publication {#pub}

> R Markdown provides an unified authoring framework for data science, combining your code, its results, and your prose commentary. R Markdown documents are fully reproducible and support dozens of output formats, like PDFs, Word files, slideshows, and more. 
- Hadley Wikcham, R for Data Science

Everything I have talked about so far is to do with the production of the statistics themselves, not preparation of the final publication, but there are tools that can help with this too. In our project with DCMS we plan to use [Rmarkdown](http://rmarkdown.rstudio.com/) (a flavour of [markdown](https://en.wikipedia.org/wiki/Markdown)) to incorporate the R code into the same document as the text of the publication.

Working in this way means that we can do all of the operations in a single file, so we have no problems with ensuring that our tables or figures are synced with the latest version of the text: everything can be produced in a single file. We can even produce templates with boilerplate text like: ‘this measure increased by X%’, and then automatically populate the X with the correct values when we run the code.

## Further Reading

You can write individual chapters using [R markdown](http://r4ds.had.co.nz/r-markdown.html), as one file per Chapter.  

Alternatively you can write the whole publication using [bookdown](https://bookdown.org/yihui/bookdown/). For a basic start in bookdown try this [blog post](http://seankross.com/2016/11/17/How-to-Start-a-Bookdown-Book.html) (we wrote this book using this to kick things off).  
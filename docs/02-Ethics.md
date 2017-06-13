# Ethical Considerations {#ethics}

The RAP is considered Data Science in that it involves an overlap of Computer Science, Statistics and Expert Domain Knowledge.  

**Data science ethics are important.** 

We consult the [ethical framework](https://www.gov.uk/government/publications/data-science-ethical-framework) before proceeding. We use the recommended Six Key Principles to structure our thinking:

1. Start with clear user need and public benefit
2. Use data and tools which have the minimum intrusion necessary
3. Create robust data science models
4. Be alert to public perceptions
5. Be as open and accountable as possible
6. Keep data secure

*Fundamentally, the public benefit of doing the project needs to be balanced against the risks of doing so.*

## Extra detail

Working through the quick checklist in the Ethical Framework we can identify those Principles that are more pertinent to a RAP project. We discuss some of these considerations in more detail here and the questions you should ask your team and stakeholders before proceeding with development.  

### Start with clear user need and public benefit
* How does the department and public benefit?
* Is this a vanity project?
* How many statistical reports does your team produce?
* What proportion of their time does this take up?
* How much copy and pasting (data movement) between softwares is involved?
* Have you demonstrated the benefit to your team? ([Show the thing.](https://gdsengagement.blog.gov.uk/2016/11/04/what-we-mean-when-we-say-show-the-thing/))

> RAP has reduced the time taken to produce a report from two months to two weeks. - placeholder

### Use data and tools which have the minimum intrusion necessary
* How intrusive and identifiable is the data you are working with?
* What is the minimum data necessary to achieve the user benefit?
* Do you really need to use sensitive data (de-identify or aggregate it)?
* Have you made synthetic data, that looks like real data, for the RAP software development?
* If identifying individuals, how widely are you searching personal data?

### Create robust data science models
* What is the quality of the data?
* How representative is the data? (what are the biases?)
* Are there any automated decisions?
* What safeguards can be implemented to validate any automatic decision making?
* What is the risk that someone will suffer a negative unintended consequence as a result of the project?
* What are all the data checking and validation steps that occur (if you can explain it to a human you should be able to code it)?

### Be alert to public perceptions
* If personal data for operational purposes, how compatible was it with the reason collected?
* Do the public agree with what you are doing?
* Automation often has negative conotations - why is RAP useful to everyone involved?

### Be as open and accountable as possible
* How open can you be about the project?
* How much oversight and accountability is there throughout the project?
* Can you explain in plain English why you are developing a RAP?
* Can you get colleagues from other departments to review your [Pull Requests](https://help.github.com/articles/about-pull-requests/)?

### Keep data secure
* How secure is your data?
* You will be using a version control software like [Git](https://gdstechnology.blog.gov.uk/2014/01/27/how-we-use-github/). How will you prevent your RAP developers from accidentally pushing sensitive data to [Github](https://stackoverflow.com/questions/13321556/difference-between-git-and-github)?
* Are you following [GDS best practice](https://gdsdata.blog.gov.uk/2017/03/27/reproducible-analytical-pipeline/)?
* Have you considered using tools, like [Git hooks](https://github.com/ukgovdatascience/dotfiles), to prevent the unintended publication of sensitive data on Github?



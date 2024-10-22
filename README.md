# gRok
 An R package for using xAI's Grok chat completions API.

First set your xAI API key as an enviornmental variable called `GROK_KEY` as shown below.
 ```
Sys.setenv(GROK_KEY='...')
```

You can now use the `grok_complete()` function to generate chat completion. 
```
# install.packages('gRok') # Pending CRAN Submission
# library(devtools)
# install_github("hisamsabouni/gRok")
library(gRok)
message <- c(
   list(messages=list(
        list(role='system',content='You are a test assistant.'),
        list(role='user',content='Testing. Just say hi and hello world and nothing else.')
       )
 ),
 model='grok-beta',
 stream=FALSE,
 temperature=0
)
grok_complete(message)
```

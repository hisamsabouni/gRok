#' Chat Completions
#'
#' This function takes in a list object that contains a users message content,
#' model, stream, and temperature settings. To use the package you must have an
#' xAI API key stored as 
#' Below is an example request.
#' @examples
#' # example code
#'  message <-
#' c(list(messages=list(
#'	list(role='system',content='You are a test assistant.'),
#'	list(role='user',content='Testing. Just say hi and hello world and nothing else.')
#' )),
#' model='grok-beta',
#' stream=FALSE,
#' temperature=0)
#' grok_complete(message)
#' @param messages a list containing a users messages
#' @return A list containing the API response from xAI
#' @export
grok_complete <- function(messages){
	endpoint <- 'https://api.x.ai/v1/chat/completions'
	#Sys.setenv(GROK_KEY='...')
	#Fetch users grok api-key
	tryCatch({
		grok_key <- Sys.getenv(x = 'GROK_KEY')
	},error=function(e){
		print('Grok API Key Not Found')
		print("Please set your key using Sys.setenv(GROK_KEY='...')")
		print("Visit https://docs.x.ai/docs to create a key")
	})
	#Flatten messages into json format
	json_body <- jsonlite::toJSON(messages, auto_unbox = TRUE,flatten = T)
	#Post response to 
	res <- httr::POST(endpoint,
					  httr::add_headers(Authorization = paste0('Bearer ',grok_key),
					  			`Content-Type`='application/json'),
					  body = json_body,
					  encode = 'raw'
	)
	tryCatch({
		data <- jsonlite::fromJSON(httr::content(res,'text',encoding = 'UTF-8'))
		return(data)
		},
		error=function(e){
			print(paste0('Error: ',e))
		})
}
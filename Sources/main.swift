import Kitura
import HeliumLogger

HeliumLogger.use()
let router = Router()
router.get("/") { req, res, next in
	res.send("Hello world")
	next()
}

router.post("/error") { request, response, next in
	let error = try request.readString() ?? ""
	print(error)
	response.send("Error received")
	next()	
}

Kitura.addHTTPServer(onPort: 5000, with: router) 
Kitura.run()

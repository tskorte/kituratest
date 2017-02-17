import Kitura
import KituraNet
import HeliumLogger
import SwiftyJSON

HeliumLogger.use()
let router = Router()
let cabins: [Int: Any] = [1 :
		[
			"name":"Taumevatn Turistforeningshytte",
			"serviceLevel": "Selvbetjent"
		],
	    2:
		[
			"name":"Storavatn",
			"serviceLevel": "Selvbetjent"
		],
	    3:
		[
			"name": "Grautheller",
			"serviceLevel": "Selvbetjent"
		]
	   ]

router.get("/") { req, res, next in
	let response = JSON(cabins)
	res.send(response.rawString() ?? "No json")
	next()
}

router.post("/id/:id") { request, response, next in
    var statusCode = HTTPStatusCode.notFound
	var responseString = "Not found"
	if let id = try request.parameters["name"] as? Int {
		let found = cabins[id]
		let json = JSON(found)
		if let jsonString = json.rawString(){
			response.status(.OK).send(json: json)
		}
	}
    response.status(statusCode)
	response.send(responseString)
	next()	
}

Kitura.addHTTPServer(onPort: 5000, with: router) 
Kitura.run()

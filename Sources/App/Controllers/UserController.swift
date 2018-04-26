import Vapor

struct UserController: RouteCollection {
    func boot( router: Router) throws {
        let userRoute = router.grouped("api", "user")
        userRoute.get(use: getAllHandler)
        userRoute.post(use: createHandler)
        userRoute.get(User.parameter, use: getHandler)
        userRoute.put(User.parameter, use: updateHandler)
        userRoute.delete(User.parameter, use: deleteHandler)
        userRoute.get(User.parameter,"acronyms", use: getAcronymsHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func createHandler(_ req: Request) throws -> Future<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap(to: HTTPStatus.self) { user in
            return user.delete(on: req).transform(to: .noContent)
        }
    }
    
    func updateHandler(_ req: Request) throws ->  Future<User> {
        return try flatMap(to: User.self, req.parameters.next(User.self), req.content.decode(User.self)) { user, updateduser in
            user.name = updateduser.name
            user.username = updateduser.username
            return user.save(on: req)
        }
    }
    
    func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
        return try req.parameter(User.self).flatMap(to: [Acronym].self ) { user in
            return try user.acronyms.query(on: req).all()
        }
    }
}

extension User: Parameter {}

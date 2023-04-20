enum Method {
    GET
    PATCH
    PUT
    POST
    DELETE
}

enum Status {
    OK = 200
    BadRequest = 400
    Unauthorized = 401
    Forbidden = 403
    NotFound = 404
    NotAcceptable = 406
    InternalServerError = 500
}

Enum ExtraData{
    alerts = 1
    notifications = 2
    rawInventory = 3
}

enum PowerOption{
    PowerOff
    PowerOn
    Restart
    ColdBoot
}

enum PowerOffOption{
    ForceOff
    GracefulShutdown
    None    
}
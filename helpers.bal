import ballerina/http;

isolated function getIdentityByNIC(string nic) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/identity/getIdentityFromNIC(targetType = json, params = {"nic": nic});
}

isolated function getPoliceRecordFromNIC(string nic) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/police/getPoliceRecordFromNIC(targetType = json, params = {"nic": nic});
}

isolated function getGSDivisionFromNIC(string nic) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/identity/getGSDivisionFromNIC(targetType = json, params = {"nic": nic});
}

isolated function getAddressByNIC(string nic) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/address/getAddressByNIC(targetType = json, params = {"nic": nic});
}

isolated function postUserRequest(@http:Payload json payload) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/health/postUserRequest.post(payload, targetType = json);
}

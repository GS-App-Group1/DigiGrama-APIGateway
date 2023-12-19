import ballerina/http;

configurable string identityClient = ?;
configurable string identityKey = ?;
configurable string addressClient = ?;
configurable string addressKey = ?;
configurable string policeClient = ?;
configurable string policeKey = ?;
configurable string mainClient = ?;
configurable string mainKey = ?;

isolated function getIdentityByNIC(string nic) returns json|error {
    http:Client dbclient = check new (identityClient);
    return check dbclient->/getIdentityFromNIC(targetType = json, params = {"nic": nic}, headers = {"API-Key": identityKey});
}

isolated function getPoliceRecordFromNIC(string nic) returns json|error {
    http:Client dbclient = check new (policeClient);
    return check dbclient->/getPoliceRecordFromNIC(targetType = json, params = {"nic": nic}, headers = {"API-Key": policeKey});
}

isolated function getAddressByNIC(string nic) returns json|error {

    http:Client dbclient = check new (addressClient);
    return check dbclient->/getAddressByNIC(targetType = json, params = {"nic": nic}, headers = {"API-Key": addressKey});
}

isolated function getUserRequestByID(string id) returns json|error {
    http:Client dbclient = check new (mainClient);
    return check dbclient->/getUserRequestByID(targetType = json, params = {"id": id}, headers = {"API-Key": mainKey});
}

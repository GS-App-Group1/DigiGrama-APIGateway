import ballerina/http;

isolated function validateNIC(string nic) returns true|error {
    if (nic == "") {
        return error("NIC cannot be empty");
    }

    if (nic.length() < 10 || nic.length() > 12) {
        return error("Invalid NIC");
    }

    return true;
}

isolated function validateEmail(string email) returns true|error {
    if (email == "") {
        return error("Email cannot be empty");
    }

    if (email.length() < 10 || email.length() > 50) {
        return error("Invalid Email");
    }

    return true;
}

isolated function updateRequestStatus(string nic, string email, string status) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/main/updateRequestStatus.put(message = {}, targetType = json, params = {"nic": nic, "email": email, "status": status});
}

isolated function updateUserRequest(string nic, string email, string address, string civilStatus, string presentOccupation, string reason) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/main/updateUserRequest.put(message = {}, targetType = json, params = {"nic": nic, "email": email, "address": address, "civilStatus": civilStatus, "presentOccupation": presentOccupation, "reason": reason});
}

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
    return check dbclient->/main/postUserRequest.post(payload, targetType = json);
}

isolated function getUserRequests(string gsDivision) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/main/getUserRequest(targetType = json, params = {"gsDivision": gsDivision});
}

isolated function getUserRequestForNIC(string nic, string email) returns json|error {
    http:Client dbclient = check new ("http://localhost:9090");
    return check dbclient->/main/getUserRequestForNIC(targetType = json, params = {"nic": nic, "email": email});
}


import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service /api on new http:Listener(9090) {

    resource function get getGSDivisionFromNIC(string nic) returns json|error? {
        _ = check validateNIC(nic);
        return getGSDivisionFromNIC(nic);
    }

    resource function get getUserRequests(string gsDivision) returns json|error? {
        return getUserRequests(gsDivision);
    }

    resource function get getUserRequestForNIC(string nic, string email) returns json|error? {
        _ = check validateNIC(nic);
        _ = check validateEmail(email);
        return getUserRequestForNIC(nic, email);
    }

    resource function put updateRequestStatus(string nic, string email, string status) returns json|error? {
        _ = check validateNIC(nic);
        _ = check validateEmail(email);
        return updateRequestStatus(nic, email, status);
    }

    resource function put updateUserRequest(string nic, string email, string address, string civilStatus, string presentOccupation, string reason) returns json|error? {
        _ = check validateNIC(nic);
        _ = check validateEmail(email);
        return updateUserRequest(nic, email, address, civilStatus, presentOccupation, reason);
    }

    resource function get checkUserDetails(string nic) returns json|error? {
        _ = check validateNIC(nic);
        json identity = check getIdentityByNIC(nic);
        json policeRecord = check getPoliceRecordFromNIC(nic);
        json address = check getAddressByNIC(nic);

        json userDetails = {
            "identity": identity,
            "policeRecord": policeRecord,
            "address": address
        };

        return userDetails;
    }
    resource function post userRequest(@http:Payload json payload) returns json|error? {
        return postUserRequest(payload);
    }

    resource function get liveness() returns http:Ok {
        return http:OK;
    }

}

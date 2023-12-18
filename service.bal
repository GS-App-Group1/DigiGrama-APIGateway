import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service /api on new http:Listener(9090) {

    resource function get getIdentityFromNIC(string nic) returns json|error? {
        return getIdentityByNIC(nic);
    }

    resource function get getPoliceRecordFromNIC(string NIC) returns json|error? {
        return getPoliceRecordFromNIC(NIC);
    }

    resource function get getGSDivisionFromNIC(string gsDivision) returns json|error? {
        return getGSDivisionFromNIC(gsDivision);
    }

    resource function get getAddressByNIC(string nic) returns json|error? {
        return getAddressByNIC(nic);
    }

    resource function post userRequest(@http:Payload json payload) returns json|error? {
        return postUserRequest(payload);
    }
}

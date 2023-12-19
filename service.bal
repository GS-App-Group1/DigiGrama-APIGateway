import ballerina/http;
import ballerina/time;

# A service representing a network-accessible API
# bound to port `9090`.
service /certificate on new http:Listener(9090) {

    resource function get requestCertificate(string id) returns json|error? {
        json userRequest = check getUserRequestByID(id);
        string nic = check userRequest.nic;

        json identity = check getIdentityByNIC(nic);
        json policeRecord = check getPoliceRecordFromNIC(nic);
        json address = check getAddressByNIC(nic);

        json certificateDetails = {
            "nic": nic,
            "issueDate": time:utcToString(time:utcNow()),
            "civilStatus": check identity.civilStatus,
            "occupation": check identity.occupation,
            "reason": check userRequest.reason,
            "dob": check identity.dob,
            "name": check identity.name,
            "gender": check identity.gender,
            "race": check identity.race,
            "nationality": check identity.nationality,
            "numberOfCrimes": check policeRecord.numberOfCrimes,
            "address": check address.address
        };

        return certificateDetails;
    }

    resource function get liveness() returns http:Ok {
        return http:OK;
    }

}

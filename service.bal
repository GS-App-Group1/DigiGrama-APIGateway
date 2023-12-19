import ballerina/http;
import ballerinax/mongodb;

type CertificateRequest record {|
    string _id;
    string nic;
    string name;
    string dob;
    string gender;
    string issueDate;
    string civilStatus;
    string occupation;
    string reason;
    string gsDivision;
    string race;
    string nationality;
    string address;
    int numberOfCrimes;
|};

# Configurations for the MongoDB endpoint
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;
configurable string collection = ?;

# A service representing a network-accessible API
# bound to port `9090`.
service /certificate on new http:Listener(9090) {
    final mongodb:Client databaseClient;

    public function init() returns error? {
        self.databaseClient = check new ({connection: {url: string `mongodb+srv://${username}:${password}@digigrama.pgauwpq.mongodb.net/`}});
    }

    resource function post insertCertificate(@http:Payload json payload) returns error? {
        CertificateRequest certificateRequest = check payload.cloneWithType(CertificateRequest);
        _ = check self.databaseClient->insert(certificateRequest, collection, database);
    }

    resource function get requestCertificate(string id) returns json|error? {
        stream<CertificateRequest, error?>|mongodb:Error CertificateStream = check self.databaseClient->find(collection, database, {_id: id});
        CertificateRequest[]|error certicates = from CertificateRequest CertificateRequest in check CertificateStream
            select CertificateRequest;

        return (check certicates).toJson();
    }

    resource function get liveness() returns http:Ok {
        return http:OK;
    }

}

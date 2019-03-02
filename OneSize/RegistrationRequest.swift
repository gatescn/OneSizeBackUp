import Foundation

struct RegistrationRequest : Codable {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let password: String
}

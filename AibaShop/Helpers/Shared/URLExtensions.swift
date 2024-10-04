import Foundation
import UniformTypeIdentifiers

extension URL {
    @dynamicMemberLookup
    struct QueryParameters {
        private let parameters: [String: String?]
        init(parameters: [String: String?]) {
            self.parameters = parameters
        }

        subscript(dynamicMember key: String) -> String? {
            parameters[key] ?? nil
        }
    }

    var queryParams: QueryParameters {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems
        else {
            return QueryParameters(parameters: [:])
        }
        let parameters = Dictionary(uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) })
        return QueryParameters(parameters: parameters)
    }

    var mimeType: String {
        UTType(filenameExtension: pathExtension)?.preferredMIMEType ?? "application/octet-stream"
    }

    /// File url video memory footprint. Remote url will return 0.
    func fileSizeInMB() -> Double? {
        guard isFileURL else { return 0.0 }
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: path)
            if let size = attributes[.size] as? NSNumber {
                return size.doubleValue / (1024 * 1024)
            }
        } catch {
            print("⚠️ Cannot get attributes for path: \(error)")
        }
        return 0.0
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

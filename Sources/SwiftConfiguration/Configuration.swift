public struct Configuration {
    
    let name: String
    let contents: Dictionary<String, Any>

    var allKeys: Set<String> {
        return Set(contents.keys)
    }
}

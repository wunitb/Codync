import Testing
@testable import CodyncKit
@testable import CodyncUI

private func request(_ title: String, kind: String? = nil) -> Entry {
    var data = EntryData()
    data.title = title
    data.toolKind = kind
    return Entry(id: title, seq: 1, botId: "b", rev: 1, kind: "permission", turn: 1, data: data, createdAt: 1, updatedAt: 1)
}

/// The settled request line's symbol, the same as the desktop's `requestIcon` (`requests.test.ts`).
@Suite struct RequestIconTests {
    @Test func aRequestOfNoKindTakesItsSymbolFromItsVerb() {
        #expect(Request.icon(kind: "execute", title: "`date`") == "terminal")
        #expect(Request.icon(kind: "other", title: "memory-search_history: search_history") == "magnifyingglass")
        #expect(Request.icon(kind: nil, title: "connectors-list_connectors: list_connectors") == "list.bullet")
    }

    @Test func anythingElseIsTheTerminal() {
        #expect(Request.icon(kind: nil, title: "anything") == "terminal")
        #expect(Request.icon(kind: nil, title: "chat-start_dev_server: start_dev_server") == "terminal")
    }

    @Test func aRunSharesItsRequestsSymbolOrIsTheTerminal() {
        #expect(Request.icon(of: [request("memory-read_memory: read_memory"), request("a.txt", kind: "read")]) == "doc.text")
        #expect(Request.icon(of: [request("a.txt", kind: "read"), request("b.txt", kind: "edit")]) == "terminal")
    }
}

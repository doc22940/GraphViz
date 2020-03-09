import XCTest
@testable import GraphViz
@testable import DOT

final class RenderingTests: XCTestCase {
    let encoder = DOTEncoder()
    let graph: Graph = {
        var graph = Graph(directed: true)
        var edge = Edge(from: "a", to: "b")
        edge.decorate = true
        graph.append(edge)
        return graph
    }()

    func testSimpleGraphRendering() throws {
        let data: Data

        do {
            data = try graph.render(using: .dot, to: .svg)
        } catch {
            throw XCTSkip("Missing dot binary")
        }

        let svg = String(data: data, encoding: .utf8)!

        let expected = #"""
            <?xml version="1.0" encoding="UTF-8" standalone="no"?>
            <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
             "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
            <!-- Generated by graphviz version 2.42.3 (20191010.1750)
             -->
            <!-- Title: %3 Pages: 1 -->
            <svg width="62pt" height="116pt"
             viewBox="0.00 0.00 62.00 116.00" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g id="graph0" class="graph" transform="scale(1 1) rotate(0) translate(4 112)">
            <title>%3</title>
            <polygon fill="white" stroke="transparent" points="-4,4 -4,-112 58,-112 58,4 -4,4"/>
            <!-- a -->
            <g id="node1" class="node">
            <title>a</title>
            <ellipse fill="none" stroke="black" cx="27" cy="-90" rx="27" ry="18"/>
            <text text-anchor="middle" x="27" y="-85.8" font-family="Times,serif" font-size="14.00">a</text>
            </g>
            <!-- b -->
            <g id="node2" class="node">
            <title>b</title>
            <ellipse fill="none" stroke="black" cx="27" cy="-18" rx="27" ry="18"/>
            <text text-anchor="middle" x="27" y="-13.8" font-family="Times,serif" font-size="14.00">b</text>
            </g>
            <!-- a&#45;&gt;b -->
            <g id="edge1" class="edge">
            <title>a&#45;&gt;b</title>
            <path fill="none" stroke="black" d="M27,-71.7C27,-63.98 27,-54.71 27,-46.11"/>
            <polygon fill="black" stroke="black" points="30.5,-46.1 27,-36.1 23.5,-46.1 30.5,-46.1"/>
            </g>
            </g>
            </svg>

            """#

        XCTAssertEqual(svg, expected)

//        let attachment = XCTAttachment(data: data, uniformTypeIdentifier: "public.svg-image")
//        attachment.lifetime = .keepAlways
//        add(attachment)
    }
}

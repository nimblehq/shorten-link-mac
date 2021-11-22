//
//  CustomTableRowView.swift
//  ShortenLink
//
//  Created by Phong Vo on 21/11/2021.
//

import Cocoa

final class CustomTableRowView: NSTableRowView {

    override func drawBackground(in dirtyRect: NSRect) {
        super.drawBackground(in: dirtyRect)
        NSColor.textColor.withAlphaComponent(0.3).set()
        let figure = NSBezierPath()
        let originX: CGFloat = 0.0
        let originY = dirtyRect.size.height
        let destinationX = dirtyRect.size.width
        figure.move(to: NSPoint(x: originX, y: originY))
        figure.line(to: NSPoint(x: destinationX, y: originY))
        figure.lineWidth = 1
        figure.stroke()
    }
}

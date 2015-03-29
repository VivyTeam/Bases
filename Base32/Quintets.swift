//
//  Quintets.swift
//  Bases
//
//  Created by Matt Rubin on 3/29/15.
//  Copyright (c) 2015 Matt Rubin. All rights reserved.
//

typealias Byte = UInt8
typealias Quintet = UInt8

func quintetsFromBytes(b: (Byte, Byte?, Byte?, Byte?, Byte?))
    -> (Quintet, Quintet, Quintet?, Quintet?, Quintet?, Quintet?, Quintet?, Quintet?)
{
    return (
        firstQuintet(b.0),
        secondQuintet(b.0, b.1 ?? 0),
        b.1.map(thirdQuintet),
        b.1.map(fourthQuintet)?(b.2 ?? 0),
        b.2.map(fifthQuintet)?(b.3 ?? 0),
        b.3.map(sixthQuintet),
        b.3.map(seventhQuintet)?(b.4 ?? 0),
        b.4.map(eigthQuintet)
    )
}


private func firstQuintet(b0: Byte) -> Quintet {
    return ((b0 & 0b11111000) >> 3)
}

private func secondQuintet(b0: Byte, b1: Byte) -> Quintet {
    return ((b0 & 0b00000111) << 2)
        |  ((b1 & 0b11000000) >> 6)
}

private func thirdQuintet(b1: Byte) -> Quintet {
    return ((b1 & 0b00111110) >> 1)
}

private func fourthQuintet(b1: Byte)(_ b2: Byte) -> Quintet {
    return ((b1 & 0b00000001) << 4)
        |  ((b2 & 0b11110000) >> 4)
}

private func fifthQuintet(b2: Byte)(_ b3: Byte) -> Quintet {
    return ((b2 & 0b00001111) << 1)
        |  ((b3 & 0b10000000) >> 7)
}

private func sixthQuintet(b3: Byte) -> Quintet {
    return ((b3 & 0b01111100) >> 2)
}

private func seventhQuintet(b3: Byte)(_ b4: Byte) -> Quintet {
    return ((b3 & 0b00000011) << 3)
        |  ((b4 & 0b11100000) >> 5)
}

private func eigthQuintet(b4: Byte) -> Quintet {
    return (b4 & 0b00011111)
}

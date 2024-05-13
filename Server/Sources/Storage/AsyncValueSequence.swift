//===----------------------------------------------------------------------===//
//
// This source file is part of a technology demo for /dev/world 2024.
//
// Copyright © 2024 ANZ. All rights reserved.
// Licensed under the MIT license
//
// See LICENSE for license information
//
// SPDX-License-Identifier: MIT
//
//===----------------------------------------------------------------------===//

import GRDB

/// A type-erased sequence that emits database values.
///
/// This is solely because we don't want to expose GRDB types outside of this package. Probably unnecessary.
///
public struct AsyncValueSequence<Element>: AsyncSequence {

    public typealias Element = Element

    let base: AsyncValueObservation<Element>

    public func makeAsyncIterator() -> Iterator {
        Iterator(base: base.makeAsyncIterator())
    }

    public struct Iterator: AsyncIteratorProtocol {

        var base: AsyncValueObservation<Element>.Iterator

        public mutating func next() async throws -> Element? {
            try await base.next()
        }
    }

}

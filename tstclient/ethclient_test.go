// Copyright 2016 The go-ethereum Authors
// This file is part of the go-tstereum library.
//
// The go-tstereum library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-tstereum library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-tstereum library. If not, see <http://www.gnu.org/licenses/>.

package tstclient

import "github.com/justchain/go-justchain"

// Verify that Client implements the tstereum interfaces.
var (
	_ = tstereum.ChainReader(&Client{})
	_ = tstereum.TransactionReader(&Client{})
	_ = tstereum.ChainStateReader(&Client{})
	_ = tstereum.ChainSyncReader(&Client{})
	_ = tstereum.ContractCaller(&Client{})
	_ = tstereum.GasEstimator(&Client{})
	_ = tstereum.GasPricer(&Client{})
	_ = tstereum.LogFilterer(&Client{})
	_ = tstereum.PendingStateReader(&Client{})
	// _ = tstereum.PendingStateEventer(&Client{})
	_ = tstereum.PendingContractCaller(&Client{})
)

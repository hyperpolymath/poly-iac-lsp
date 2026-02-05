# SPDX-License-Identifier: PMPL-1.0-or-later
# SPDX-FileCopyrightText: 2026 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>

defmodule PolyIaC.LSPTest do
  use ExUnit.Case
  doctest PolyIaC.LSP

  test "returns version" do
    assert PolyIaC.LSP.version() == "0.1.0"
  end
end

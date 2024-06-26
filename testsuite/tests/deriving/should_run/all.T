# Args to vt are:
#	extra compile flags
#	extra run flags
#	expected process return value, if not zero

test('drvrun001', when(fast(), skip), compile_and_run, [''])
test('drvrun002', when(fast(), skip), compile_and_run, [''])
test('drvrun003', when(fast(), skip), compile_and_run, [''])
test('drvrun004', when(fast(), skip), compile_and_run, [''])
test('drvrun005', when(fast(), skip), compile_and_run, [''])
test('drvrun006', normal, compile_and_run, [''])
test('drvrun007', when(fast(), skip), compile_and_run, [''])
test('drvrun008', when(fast(), skip), compile_and_run, ['-funbox-strict-fields'])
test('drvrun009', when(fast(), skip), compile_and_run, [''])
test('drvrun010', when(fast(), skip), compile_and_run, [''])
test('drvrun011', when(fast(), skip), compile_and_run, [''])
test('drvrun012', when(fast(), skip), compile_and_run, [''])
test('drvrun013', when(fast(), skip), compile_and_run, [''])
test('drvrun014', when(fast(), skip), compile_and_run, [''])
test('drvrun015', when(fast(), skip), compile_and_run, [''])
test('drvrun016', when(fast(), skip), compile_and_run, ['-funbox-strict-fields'])
test('drvrun017', when(fast(), skip), compile_and_run, [''])
test('drvrun018', when(fast(), skip), compile_and_run, [''])
test('drvrun019', normal, compile_and_run, [''])
test('drvrun020', normal, compile_and_run, [''])
test('drvrun021', normal, compile_and_run, [''])
test('T2529', normal, compile_and_run, [''])
test('drvrun-functor1', normal, compile_and_run, [''])
test('drvrun-foldable1', normal, compile_and_run, [''])
test('T4136', normal, compile_and_run, [''])
test('T4528a', normal, compile_and_run, [''])
test('T5041', normal, compile_and_run, [''])
test('T5628', normal, compile_and_run, [''])
test('T5712', normal, compile_and_run, [''])
test('T7401', normal, compile_and_run, [''])
test('T7931', normal, compile_and_run, [''])
# T8280 is superseded by T10104
test('T9576', exit_code(1), compile_and_run, [''])
test('T9830', [], multimod_compile_and_run, ['T9830', '-v0'])
test('T10104', normal, compile_and_run, [''])
test('T10447', normal, compile_and_run, [''])
test('T10598_bug', normal, compile_and_run, [''])
test('T10598_run', normal, compile_and_run, [''])
test('T11535',
     [when(opsys('mingw32'), expect_broken_for(12210, ghci_ways)),
      omit_ghci], # withExecBuffer: Too large
     compile_and_run, [''])
test('T14918', normal, compile_and_run, [''])
test('T20371', normal, compile_and_run, ['-dppr-debug'])

Type abstractions
=================

.. extension:: TypeAbstractions
    :shortdesc: Enable type abstraction syntax in patterns and type variable binders.

    :since: 9.6.1

    :status: Partially implemented

    Allow the use of type abstraction syntax.

The :extension:`TypeAbstractions` extension provides a way to explicitly bind
scoped type or kind variables using the ``@a`` syntax. The feature is only
partially implemented, and this text covers only the implemented parts, whereas
the full specification can be found in GHC Proposals `#448 <https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0448-type-variable-scoping.rst>`__
and `#425 <https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0425-decl-invis-binders.rst>`__.


.. _type-abstractions-in-patterns:

Type Abstractions in Patterns
-----------------------------

The type abstraction syntax can be used in patterns that match a data
constructor. The syntax can't be used with record patterns or infix patterns.
This is useful in particular to bind existential type variables associated with
a GADT data constructor as in the following example::

    {-# LANGUAGE AllowAmbiguousTypes #-}
    {-# LANGUAGE GADTs #-}
    {-# LANGUAGE RankNTypes #-}
    {-# LANGUAGE TypeApplications #-}
    import Data.Proxy

    data Foo where
      Foo :: forall a. (Show a, Num a) => Foo

    test :: Foo -> String
    test x = case x of
      Foo @t -> show @t 0

    main :: IO ()
    main = print $ test (Foo @Float)

In this example, the case in ``test``` is binding an existential variable introduced
by ``Foo`` that otherwise could not be named and used.

It's possible to bind variables to any part of the type arguments to a constructor;
there is no need for them to be existential. In addition, it's possible to "match" against
part of the type argument using type constructors.

For a somewhat-contrived example::

    foo :: (Num a) => Maybe [a] -> String
    foo (Nothing @[t]) = show (0 :: t)
    foo (Just @[t] xs) = show (sum xs :: t)

Here, we're binding the type variable t to be the type of the elements of the list type
which is itself the argument to Maybe.

The order of the type arguments specified by the type applications in a pattern is the same
as that for an expression: either the order as given by the user in an explicit ``forall`` in the
definition of the data constructor, or if that is not present, the order in which the type
variables appear in its type signature from left to right.

For example if we have the following declaration in GADT syntax::

    data Foo :: * -> * where
      A :: forall s t. [(t,s)] -> Foo (t,s)
      B :: (t,s) -> Foo (t,s)

Then the type arguments to ``A`` will match first ``s`` and then ``t``, while the type arguments
to ``B`` will match first ``t`` and then ``s``.

Type arguments appearing in patterns can influence the inferred type of a definition::

    foo (Nothing @Int) = 0
    foo (Just x) = x

will have inferred type::

    foo :: Maybe Int -> Int

which is more restricted than what it would be without the application::

    foo :: Num a => Maybe a -> a

For more information and detail regarding type applications in patterns, see the paper
`Type variables in patterns <https://arxiv.org/pdf/1806.03476>`__ by Eisenberg, Breitner
and Peyton Jones. Relative to that paper, the implementation in GHC for now at least makes one
additional conservative restriction, that type variables occurring in patterns must not
already be in scope, and so are always new variables that only bind whatever type is
matched, rather than ever referring to a variable from an outer scope. Type wildcards
``_`` may be used in any place where no new variable needs binding.
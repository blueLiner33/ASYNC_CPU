#ifndef BISON_PARSE_H
# define BISON_PARSE_H

#ifndef YYSTYPE
typedef union {long itype; tree ttype; char *strtype; enum tree_code code; } yystype;
# define YYSTYPE yystype
# define YYSTYPE_IS_TRIVIAL 1
#endif
# define	IDENTIFIER	257
# define	TYPENAME	258
# define	SCSPEC	259
# define	TYPESPEC	260
# define	TYPE_QUAL	261
# define	CONSTANT	262
# define	STRING	263
# define	ELLIPSIS	264
# define	SIZEOF	265
# define	ENUM	266
# define	IF	267
# define	ELSE	268
# define	WHILE	269
# define	DO	270
# define	FOR	271
# define	SWITCH	272
# define	CASE	273
# define	DEFAULT	274
# define	BREAK	275
# define	CONTINUE	276
# define	RETURN	277
# define	GOTO	278
# define	ASM_KEYWORD	279
# define	GCC_ASM_KEYWORD	280
# define	TYPEOF	281
# define	ALIGNOF	282
# define	SIGOF	283
# define	ATTRIBUTE	284
# define	EXTENSION	285
# define	LABEL	286
# define	AGGR	287
# define	VISSPEC	288
# define	DELETE	289
# define	NEW	290
# define	OVERLOAD	291
# define	THIS	292
# define	OPERATOR	293
# define	CXX_TRUE	294
# define	CXX_FALSE	295
# define	NAMESPACE	296
# define	TYPENAME_KEYWORD	297
# define	USING	298
# define	LEFT_RIGHT	299
# define	TEMPLATE	300
# define	TYPEID	301
# define	DYNAMIC_CAST	302
# define	STATIC_CAST	303
# define	REINTERPRET_CAST	304
# define	CONST_CAST	305
# define	SCOPE	306
# define	EMPTY	307
# define	PTYPENAME	308
# define	NSNAME	309
# define	THROW	310
# define	ASSIGN	311
# define	OROR	312
# define	ANDAND	313
# define	MIN_MAX	314
# define	EQCOMPARE	315
# define	ARITHCOMPARE	316
# define	LSHIFT	317
# define	RSHIFT	318
# define	POINTSAT_STAR	319
# define	DOT_STAR	320
# define	UNARY	321
# define	PLUSPLUS	322
# define	MINUSMINUS	323
# define	HYPERUNARY	324
# define	PAREN_STAR_PAREN	325
# define	POINTSAT	326
# define	TRY	327
# define	CATCH	328
# define	TYPENAME_ELLIPSIS	329
# define	PRE_PARSED_FUNCTION_DECL	330
# define	EXTERN_LANG_STRING	331
# define	ALL	332
# define	PRE_PARSED_CLASS_DECL	333
# define	TYPENAME_DEFN	334
# define	IDENTIFIER_DEFN	335
# define	PTYPENAME_DEFN	336
# define	END_OF_LINE	337
# define	END_OF_SAVED_INPUT	338


extern YYSTYPE yylval;

#endif /* not BISON_PARSE_H */
#define YYEMPTY		-2

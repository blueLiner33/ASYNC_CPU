#ifndef BISON_BI_PARSER_H
# define BISON_BI_PARSER_H

#ifndef YYSTYPE
typedef union
{
  char *string;
  struct def *def;
  struct variation *variation;
  struct node *node;
} yystype;
# define YYSTYPE yystype
# define YYSTYPE_IS_TRIVIAL 1
#endif
# define	DEFOP	257
# define	STRING	258


extern YYSTYPE yylval;

#endif /* not BISON_BI_PARSER_H */

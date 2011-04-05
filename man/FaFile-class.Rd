\name{FaFile}
\Rdversion{1.1}
\docType{class}
\alias{FaFile-class}
% con/destructors
\alias{FaFile}
\alias{open.FaFile}
\alias{close.FaFile }
% accessors
\alias{isOpen,FaFile-method}
% methods
\alias{indexFa,FaFile-method}
\alias{scanFaIndex,FaFile-method}
\alias{countFa,FaFile-method}
\alias{scanFa,FaFile,GRanges-method}
\alias{scanFa,FaFile,missing-method}

\title{Manipulate indexed fasta files.}

\description{

  Use \code{FaFile()} to create a reference to an indexed fasta
  file. The reference remains open across calls to methods, avoiding
  costly index re-loading.

}

\usage{

## Opening / closing

FaFile(file, ...)
\S3method{open}{FaFile}(con, ...)
\S3method{close}{FaFile}(con, ...)

## accessors; also path(), index()

\S4method{isOpen}{FaFile}(con, rw="")

## actions

\S4method{indexFa}{FaFile}(file, ...)
\S4method{scanFaIndex}{FaFile}(file, ...)
\S4method{countFa}{FaFile}(file, ...)
\S4method{scanFa}{FaFile,GRanges}(file, param=GRanges(), ...)
\S4method{scanFa}{FaFile,missing}(file, param=GRanges(), ...)
}

\arguments{

  \item{con}{An instance of \code{FaFile}.}

  \item{file}{A character(1) vector of the fasta file path (for
    \code{FaFile}), or an instance of class \code{FaFile}.}

  \item{param}{An optional \code{\linkS4class{GRanges}} instance to
    select reads (and sub-sequences) for input.}

  \item{...}{Additional arguments, currently unused.}

  \item{rw}{Mode of file; ignored.}

}

\section{Objects from the Class}{

  Objects are created by calls of the form \code{FaFile()}.

}

\section{Fields}{

  The \code{FaFile} class inherits fields from the
  \code{\linkS4class{RsamtoolsFile}} class.

}

\section{Functions and methods}{

  Opening / closing:
  \describe{

    \item{open.FaFile}{Opens the (local or remote) \code{path} and
      \code{index} files.  Returns a \code{FaFile} instance.}

    \item{close.FaFile}{Closes the \code{FaFile} \code{con}; returning
      (invisibly) the updated \code{FaFile}. The instance may be
      re-opened with \code{open.FaFile}.}

  }

  Accessors: 
  \describe{

    \item{path}{Returns a character(1) vector of the fasta path name.}

    \item{index}{Returns a character(1) vector of fasta index name
    (minus the '.fai' extension).}

  }

  Methods:
  \describe{

    \item{indexFa}{Visit the path in \code{path(file)} and create an
      index file (with the extension \sQuote{.fai}).}

    \item{scanFaIndex}{Read the sequence names and and widths of
      recorded in an indexed fasta file, returning the information as a
      \code{\linkS4class{GRanges}} object.}

    \item{countFa}{Return the number of records in the fasta file.}

    \item{scanFa}{Return the sequences indicated by \code{param} as a
      \code{\linkS4class{DNAStringSet}} instance. \code{seqnames(param)}
      selects the sequences to return; \code{start(param)} and
      \code{end{param}} define the (1-based) region of the sequence to
      return. Values of \code{end(param)} greater than the width of the
      sequence are set to the width of the sequence. When \code{param}
      is missing, all records are selected. When \code{param} is
      \code{GRanges()}, no records are selected.}

    \item{show}{Compactly display the object.}

  }

}
\author{Martin Morgan}

\examples{

fl <- system.file("extdata", "ce2dict1.fa", package="Rsamtools")
fa <- open(FaFile(fl))                   # open
countFa(fa)
(idx <- scanFaIndex(fa))
(dna <- scanFa(fa, idx[1:2]))
ranges(idx) <- narrow(ranges(idx), -10)  # last 10 nucleotides
(dna <- scanFa(fa, idx[1:2]))

}

\keyword{classes}
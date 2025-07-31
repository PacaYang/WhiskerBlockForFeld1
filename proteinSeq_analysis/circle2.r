# Load libraries
library(circlize)
library(readr)

# Read data
df <- read_csv("similarity_matrix.csv")


# Optional: filter out low similarity
df <- df[df$similarity > 0.7, ]

# Get unique nodes (sectors) and sort them
nodes <- unique(c(df$seq1, df$seq2))
nodes <- sort(nodes)  # assumes they are named "1", "2", ..., "30" as strings

# Create color palettes
blues <- colorRampPalette(c("#deebf7", "#3182bd"))(11)
purples <- colorRampPalette(c("#f2e5ff", "#6a51a3"))(8)
reds  <- colorRampPalette(c("#fee0d2", "#de2d26"))(8)
greens <- colorRampPalette(c("#e5f5e0", "#31a354"))(7)
teals <- colorRampPalette(c("#fff9c4", "#f9a825"))(15)

# Assign colors to groups
grid.col <- c(blues, purples, reds, greens, teals)
names(grid.col) <- nodes  # Make sure the names match the actual node names in your CSV

length(df$col)
length(grid.col[df$seq1])

df$col <- grid.col[match(df$seq1, names(grid.col))]
df$col <- ifelse(df$seq1 == df$seq2, "#FFFFFF00", df$col)


# Create the base plot with space for labels
circos.clear()
circos.par(start.degree = 90, gap.degree = 2)

chordDiagram(
  df,
  grid.col = grid.col,  # <- assign color to each node
  col = df$col,
  transparency = 0.5,
  directional = 0,
  annotationTrack = c("name", "grid"),
  preAllocateTracks = list(track.height = 0.1)
)



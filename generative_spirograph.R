# Generative Spirograph in R
# Run with: Rscript generative_spirograph.R
# It creates a colorful hypotrochoid-style plot and saves it as spirograph.png.

set.seed(5337)

# Pick parameters that create a pleasant looping curve.
R <- 8
r <- 3
d <- 6
turns <- 18
n_points <- 7000

theta <- seq(0, turns * pi, length.out = n_points)

x <- (R - r) * cos(theta) + d * cos(((R - r) / r) * theta)
y <- (R - r) * sin(theta) - d * sin(((R - r) / r) * theta)

# Add a second slowly changing signal for color variation.
color_signal <- sin(theta * 0.7) + cos(theta * 1.3)
palette <- hcl.colors(256, palette = "Plasma")
colors <- palette[cut(color_signal, breaks = 256, labels = FALSE)]

png("spirograph.png", width = 1400, height = 1400, res = 180)
par(bg = "#07111f", mar = rep(0, 4))
plot(
  x, y,
  type = "n",
  axes = FALSE,
  asp = 1,
  xlab = "",
  ylab = ""
)

# Draw short line segments so the curve can change color smoothly.
segments(
  x[-length(x)], y[-length(y)],
  x[-1], y[-1],
  col = colors[-1],
  lwd = 1.8
)

# Add a small star field for a playful background.
stars <- 250
points(
  runif(stars, min(x) * 1.15, max(x) * 1.15),
  runif(stars, min(y) * 1.15, max(y) * 1.15),
  pch = 16,
  cex = runif(stars, 0.15, 0.55),
  col = adjustcolor("white", alpha.f = runif(stars, 0.15, 0.7))
)

text(
  0, min(y) * 1.05,
  "Generative Spirograph in R",
  col = adjustcolor("white", alpha.f = 0.8),
  cex = 1.1,
  family = "sans"
)

dev.off()

message("Saved spirograph.png — open it to see the generated artwork!")

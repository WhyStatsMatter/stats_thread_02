# Install and load necessary libraries
install.packages(c("ggplot2", "FactoMineR"))
library(ggplot2)
library(FactoMineR)

# Using iris dataset for PCA
data(iris)
res.pca <- PCA(iris[, -5], scale.unit=TRUE, ncp=4, graph=FALSE)

# Image 1: 2D visualization of PCA
image1_df <- data.frame(res.pca$ind$coord, Species=iris$Species)
image1 <- ggplot(image1_df, aes(x=Dim.1, y=Dim.2, color=Species)) +
  geom_point(size=4) +
  labs(title="PCA on Iris Data", x="Principal Component 1", y="Principal Component 2") +
  theme_minimal()+
  theme(
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "white")
  )
ggsave("PCA_image1.png", image1, width=5, height=4)

# Image 2: Scree plot (variance explained by each principal component)
image2 <- barplot(
  res.pca$eig[, 2],
  names.arg = 1:nrow(res.pca$eig),
  las = 2,
  main = "Variance Explained by Principal Components",
  xlab = "Principal Component",
  ylab = "Variance Explained (%)",
  bg = "white"
)
dev.copy(png, "PCA_image2.png")
dev.off()

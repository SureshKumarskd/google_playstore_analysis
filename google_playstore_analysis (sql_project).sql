select * 
from dbo.googleplaystore

-- identifying null values --

SELECT *
FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL

-- Removing null values --

Delete FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL


-- Overall view of daatset --

select 
COUNT(distinct App) as Total_Apps,
COUNT(DISTINCT category) as Total_Category
 from dbo.googleplaystore

 -- Explor app cateogries --

 SELECT 
Category,
COUNT(App) AS Total_app
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY Total_app DESC

-- top rated free apps --
select
app,
category,
rating,
reviews
from dbo.googleplaystore
where Type = 'free' AND Rating <> 'NaN'
order by Rating desc


-- top 10 rated free apps --
select top 10
app,
category,
rating,
reviews
from dbo.googleplaystore
where Type = 'free' AND Rating <> 'NaN'
order by Rating desc

-- most reviewed app -

select top 10
category,
APP,
reviews
from dbo.googleplaystore
order by reviews desc

-- Average rating by category --

SELECT top 5
Category, 
AVG(TRY_CAST(Rating AS FLOAT)) AS Avg_Rating
FROM dbo.googleplaystore
group by category
order BY Avg_Rating

-- top categories by number of installs --

SELECT TOP 10
Category,
SUM(CAST(REPLACE(SUBSTRING(Installs, 1, PATINDEX('%[^0-9]%', Installs + ' ') - 1), ',' , ' ') AS INT)) AS total_installs
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY total_installs DESC

-- avg sentiment polarity by app category --

select TOP 10
category,
AVG(TRY_CAST(sentiment_polarity AS FLOAT)) AS avg_sentiment_polarity
from dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews 
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App 
group by Category
order by avg_sentiment_polarity DESC

-- sentiment reviews by app category --

select 
category,
sentiment
from dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App

------
select top 10
category,
sentiment,
COUNT(*) as Total_sentiment
from dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
where Sentiment <>'nan'
group by Category,Sentiment
order by Total_sentiment desc

---- DELETE UNWANTED THINGS ----
SELECT 
sentiment, 
Translated_Review, 
Sentiment_Polarity , 
Sentiment_Subjectivity
FROM dbo.googleplaystore_user_reviews
WHERE sentiment = 'nan'
or Translated_Review ='nan'
or Sentiment_Polarity ='nan'
or Sentiment_Subjectivity ='nan'

DELETE
FROM dbo.googleplaystore_user_reviews
WHERE sentiment = 'nan'
or Translated_Review ='nan'
or Sentiment_Polarity ='nan'
or Sentiment_Subjectivity ='nan';


select * from dbo.googleplaystore

select * from dbo.googleplaystore_user_reviews




class Article :
    def __init__(self, title, content, author, publishdate, created_by, image):
        self.title = title
        self.content = content
        self.author = author
        self.publishdate = publishdate
        self.created_by = created_by
        self.image = image
        
    def __repr__(self):
        return f'| {self.title} by {self.author} |'

def get_articles():
    data = {
        "data": {
            "2": {
            "title": "Aku Nick",
            "content": "<p>sip</p>",
            "author": "Anjay",
            "publishdate": "07-02-2024 15:07",
            "created_by": 1,
            "image": "http://nutrizoom.site/view_image/3064ed69-dc30-4147-8388-f3a0b549758d.jpg"
            },
            "3": {
            "title": "Artikel1",
            "content": "<p>Liverpool Juara EPL, UCL, UEL, CLUB WORLD CUP, FA CUP, CARABAO CUP!</p>",
            "author": "author1",
            "publishdate": "23-02-2024 08:33",
            "created_by": 6,
            "image": "http://nutrizoom.site/view_image/d94f2fb3-f6a9-40e7-8d02-dc928a284ec8.jpg"
            },
            "5": {
            "title": "Artikel3",
            "content": "<p>Arsenal too soon di EPL, UCL, UEL, CLUB WORLD CUP, FA CUP, CARABAO CUP!</p>",
            "author": "author2",
            "publishdate": "23-02-2024 08:36",
            "created_by": 6,
            "image": "http://nutrizoom.site/view_image/8574c629-8471-41be-a36e-c5a772aa11aa.jpg"
            },
            "6": {
            "title": "Bambang",
            "content": "<p>asdasd</p>",
            "author": "bambang",
            "publishdate": "23-02-2024 11:36",
            "created_by": 1,
            "image": "http://nutrizoom.site/view_image/66e171fe-7106-4ceb-a65d-35dca124e230.jpg"
            }
        },
        "total_pages": 1,
        "current_page": 1,
        "per_page": 10,
        "total_items": 4
    }
    headers = data['data'].keys()
    articles = []        
    data = data['data']
    for header in headers:
        title = data[header]['title']
        content = data[header]['content']
        author = data[header]['author']
        publishdate = data[header]['publishdate']
        created_by = data[header]['created_by']
        image = data[header]['image']
        articles.append(Article(title, content, author, publishdate, created_by, image))
        
    return articles

result = get_articles()
print(result)

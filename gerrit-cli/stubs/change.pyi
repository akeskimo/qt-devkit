#/usr/bin/env python3

class Change:
    self.project: str
    self.branch: str
    self.id: str
    self.number: int
    self.subject: str

    class Owner:
        self.name: str
        self.email: str
        self.username: str

    self.owner: Owner
    self.url: str
    self.commitMessage: str
    self.createdOn: int
    self.lastUpdated: int
    self.open: bool
    self.status: str


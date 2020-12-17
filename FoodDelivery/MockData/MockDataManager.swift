

protocol Team {
  var marks: [String] { get }
  var values: [String] { get }
  var playerPictures: [[String]] { get }
  
}

struct Pizza: Team {
  let marks = ["4/5", "3/5", "4/5", "2/5"]
  let values = ["50", "30", "30", "40"]
  let playerPictures = [
    ["Pizza1"],
    ["Pizza2", "Pizza2", "Pizza2", "Pizza1"],
    ["Pizza2", "Pizza2", "Pizza1", "Pizza1"],
    ["Pizza2", "Pizza2"]
  ]
}

struct Sushi: Team {
  let values = ["150", "130", "130", "140"]
  let marks = ["1/5", "3/5", "3/5", "5/5"]
  let playerPictures = [
    ["categ-2"],
    ["categ-2", "categ-2", "categ-2", "categ-2"],
    ["categ-2", "categ-2", "categ-2", "categ-2"],
    ["categ-2", "categ-2"]
  ]
}

struct Drinks: Team {
  let values = ["510", "320", "310", "420"]
  let marks = ["3/5", "2/5", "4/5", "5/5"]
  let playerPictures = [
    ["Parrots-goalkeeper"],
    ["Parrots-d1", "Parrots-d2", "Parrots-d3", "Parrots-d4"],
    ["Parrots-m1", "Parrots-m2", "Parrots-m3", "Parrots-m4"],
    ["Parrots-f1", "Parrots-f2"]
  ]
}



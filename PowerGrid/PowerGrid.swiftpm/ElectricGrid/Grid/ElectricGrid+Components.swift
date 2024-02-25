import Foundation

extension ElectricGrid {
    public func addComponent(_ component: any Component, at index: Int) {
        cells[index].component = component
        if let customer = component as? (any Customer) {
            customers.append(customer)
            
            for (i, data) in consumptionData.enumerated() {
                if data.componentType == .commercial && customer is Commercial {
                    consumptionData[i].amount += customer.demandForecast[i/3]
                } else if data.componentType == .residential && customer is Residential {
                    consumptionData[i].amount += customer.demandForecast[i/3]
                } else if data.componentType == .industrial && customer is Industrial {
                    consumptionData[i].amount += customer.demandForecast[i/3]
                }
            }
        }
        if let powerPlant = component as? (any PowerPlant) {
            powerPlants.append(powerPlant)
        }
    }
    
    public func removeComponent(at index: Int) {
        if let component = cells[index].component {
            if let customer = component as? (any Customer),
               let i = customers.firstIndex(where: {$0.id == customer.id}) {
                customers.remove(at: i)
                for (j, data) in consumptionData.enumerated() {
                    guard j > 2 else {
                        continue
                    }
                    if data.componentType == .commercial && customer is Commercial {
                        consumptionData[j].amount -= customer.demandForecast[j/3]
                    } else if data.componentType == .residential && customer is Residential {
                        consumptionData[j].amount -= customer.demandForecast[j/3]
                    } else if data.componentType == .industrial && customer is Industrial {
                        consumptionData[j].amount -= customer.demandForecast[j/3]
                    }
                }
            }
            if let powerPlant = component as? (any PowerPlant),
               let i = powerPlants.firstIndex(where: {$0.id == powerPlant.id}) {
                powerPlants.remove(at: i)
            }
        }
        cells[index].component = nil
    }
}

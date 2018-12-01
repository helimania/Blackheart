import QtQuick 2.2
import QtMultimedia 5.0
import "../variables.js" as Global

Item {
    id: sequentialDemo;

    SequentialAnimation {
        running: true
        loops: 1

        // We want a small pause at the beginning, but we only want it to happen once.
        PauseAnimation {
            duration: 1000
        }

 //       PropertyAction {
 //           target: valueSource
 //           property: "start"
 //           value: false
 //       }


        SequentialAnimation {
            loops: Animation.Infinite

            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 10
                    duration: 300
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 12.1
                    duration: 300
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    to: 25
                    duration: 300
                }
            }
            NumberAnimation {
                target: valueSource
                property: "cornersLamp"
                easing.type: Easing.InOutSine
                to: 0.7
                duration: 200
            }
            PauseAnimation {
                duration: 500
            }
            NumberAnimation {
                target: valueSource
                property: "lobeamLamp"
                easing.type: Easing.InOutSine
                to: 0.7
                duration: 200
            }

            PauseAnimation {
                duration: 3000
            }

            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 0.99
                    duration: 1000
                }

                NumberAnimation {
                    target: valueSource
                    property: "battLamp"
                    easing.type: Easing.InOutSine
                    to: 0.1
                    duration: 200
                }
            }
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "lobeamLamp"
                    easing.type: Easing.InOutSine
                    to: 0.1
                    duration: 200
                }
                NumberAnimation {
                    target: valueSource
                    property: "hibeamLamp"
                    easing.type: Easing.InOutSine
                    to: 0.7
                    duration: 200
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 0.97
                    duration: 1000
                }

            }

            PropertyAction {
                target: valueSource
                property: "start"
                value: true
            }
            PauseAnimation {
                duration: 3000
            }

            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 30
                    duration: 3000

                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    //from: 1
                    to: 6.1
                    duration: 3000
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 10
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 13.2
                    duration: 3000
                }

            }
            ParallelAnimation {
                // We changed gears so we lost a bit of speed.

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 26
                    duration: 600
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    from: 6
                    to: 2.4
                    duration: 600
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 12
                    duration: 600
                }
            }
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "lobeamLamp"
                    easing.type: Easing.InOutSine
                    to: 0.7
                    duration: 200
                }
                NumberAnimation {
                    target: valueSource
                    property: "hibeamLamp"
                    easing.type: Easing.InOutSine
                    to: 0.1
                    duration: 200
                }
            }
            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 60
                    duration: 3000
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 5.6
                    duration: 3000
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 25
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    to: 20
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 13.4
                    duration: 3000
                }
            }
            ParallelAnimation {
                // We changed gears so we lost a bit of speed.

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 56
                    duration: 600
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2.3
                    duration: 600
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 30
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 13
                    duration: 600
                }
            }
            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 100
                    duration: 3000
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 5.1
                    duration: 3000
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 50
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    to: 17
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 14.1
                    duration: 3000
                }
            }
            ParallelAnimation {
                // We changed gears so we lost a bit of speed.

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 96
                    duration: 600
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2.2
                    duration: 600
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 52
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 13.8
                    duration: 600
                }
            }

            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 140
                    duration: 3000
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 6.2
                    duration: 3000
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 80
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    to: 16
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 14.2
                    duration: 3000
                }
            }

            // Start downshifting.

            // Fifth to fourth gear.
            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.Linear
                    to: 100
                    duration: 5000
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 3.1
                    duration: 5000
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 98
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    to: 15
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 13.8
                    duration: 5000
                }
            }

            // Fourth to third gear.

            NumberAnimation {
                target: valueSource
                property: "rpm"
                easing.type: Easing.InOutSine
                to: 5.5
                duration: 600
            }


            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 60
                    duration: 5000
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2.6
                    duration: 5000
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 90
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    to: 10
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 13.6
                    duration: 3000
                }
            }

            // Third to second gear.

            NumberAnimation {
                target: valueSource
                property: "rpm"
                easing.type: Easing.InOutSine
                to: 6.3
                duration: 600
            }


            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 30
                    duration: 5000
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2.6
                    duration: 5000
                }

                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 93
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    to: 7
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 13.3
                    duration: 5000
                }
            }


            NumberAnimation {
                target: valueSource
                property: "rpm"
                easing.type: Easing.InOutSine
                to: 6.5
                duration: 600
            }


            // Second to first gear.
            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 0
                    duration: 5000
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 0.972
                    duration: 4500
                }

               NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 0
                    duration: 4500
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    to: 25
                    duration: 4500
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 11.4
                    duration: 4500
                }
            }
            ParallelAnimation {

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 0
                    duration: 300
                }

               NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    to: 0
                    duration: 300
                }
                NumberAnimation {
                    target: valueSource
                    property: "batt"
                    easing.type: Easing.InOutSine
                    to: 11.2
                    duration: 300
                }
            }
            NumberAnimation {
                target: valueSource
                property: "battLamp"
                easing.type: Easing.InOutSine
                to: 0.7
                duration: 200
            }

            PauseAnimation {
                duration: 2000
            }
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 0
                    duration: 300
                }
            }
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "lobeamLamp"
                    easing.type: Easing.InOutSine
                    to: 0.1
                    duration: 200
                }
                NumberAnimation {
                    target: valueSource
                    property: "cornersLamp"
                    easing.type: Easing.InOutSine
                    to: 0.1
                    duration: 200
                }
            }
            PauseAnimation {
                duration: 1000
            }
            PropertyAction {
                target: valueSource
                property: "start"
                value: false
            }
            PauseAnimation {
                duration: 2000
            }
        }
    }
    
}

import 'package:WMS_Application/core/utils/math_utils.dart';
import 'package:flutter/material.dart';

class Rms_oms_deets extends StatefulWidget {
  @override
  createState() => new Rms_oms_deetsState();
}

class Rms_oms_deetsState extends State<Rms_oms_deets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
                                                    width: size.width,
                                                    height: 100,
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "RMS No :: VX-ER32",
                                                            textScaleFactor: 1,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(border: Border.all(width: 1),),
                                                                child: Text("OMS No"),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(border: Border.all(width: 1),),
                                                                child: Text("Flow(LPS)"),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(border: Border.all(width: 1),),
                                                                child: Text("Volume(m³)"),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(border: Border.all(width: 1),),
                                                                child: Text("Irrigation\nStatus"),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(border: Border.all(width: 1),),
                                                                child: Text("Pressure"),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
    
        ),
      );
}

import { createStore, compose, combineReducers } from 'redux';
import PropTypes from 'prop-types';

export const types = {
    hello: {
        text: PropTypes.string.isRequired,
    },
};

const pipe = arg => (...fns) => compose(...fns.reverse())(arg);
const newDict = (k, v) => { const d = {}; d[k] = v; return d; };
const mapDict = (action) => dict => Object.entries(dict).reduce((dict, entry) => ({ ...dict, ...action(...entry) }), {});
const flatten = (pre = '', ref = types) => mapDict((key, value) =>
    Object.values(ref[key])[0] instanceof Function ?
        newDict(`${pre}${key}`, value) :
        flatten(`${pre}${key}.`, ref[key])(value)
);
const toReducer = mapDict((name, reducers) =>
    newDict(name, (state = reducers.state, action) =>
        action.type.startsWith(name) ?
            reducers[action.type.substring(1 + name.length)](state, action.payload) : state)
);

export const store = pipe({
    hello: {
        state: { text: 'Hello world' },
        set: (state, { text }) => ({ ...state, text }),
    },
})(flatten(), toReducer, combineReducers, createStore);

export { connect } from 'react-redux';
